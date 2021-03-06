import NewEntryButtonForm from "./new-entry-button-form";
import RecentHistory from "./recent-history";
import EntryModal from "./entry-modal";
import Notice from "./notice";

export default React.createClass({
  getInitialState() {
    return {
      currentEntry: null,
      transactionDateFrom: null,
      transactionDateTo: null,
      transactions: []
    };
  },
  componentDidMount() {
    var dateFrom = moment().subtract(7, 'days').toISOString();
    var dateTo = null;
    this.loadHistories(dateFrom, dateTo);
  },
  loadHistories(dateFrom, dateTo) {
    $.when(
      $.ajax(`api/transactions`, { dataType: 'json', data: {
        dateFrom: dateFrom,
        dateTo:   dateTo
      } }),
      $.ajax(`api/items`       , { dataType: 'json' })
    ).then((trxRes, itemsRes) => {
      var currentTransactions = this.state.transactions;
      this.setState({
        transactionDateFrom: dateFrom,
        transactions:        currentTransactions.concat(trxRes[0].data),
        items:               itemsRes[0].data
      });
    }).fail((err) => {
      console.log(err);
      this.error("エラーが発生しました。");
    });
  },
  deleteTransaction(transaction) {
    $.ajax(`${this.props.url}/transactions/${transaction.id}`, {
      method: 'DELETE'
    }).then((data) => {
      this.setState({
        transactions: _(this.state.transactions).reject((one) => one.id === transaction.id)
      });
      this.info("登録を削除しました。");
    }).fail((err) => {
      console.log(err);
      this.error("エラーが発生しました。");
    });
  },
  loadFollowingHistories() {
    var dateTo = moment(this.state.transactionDateFrom).subtract(1, 'day');
    var dateFrom = dateTo.clone().subtract(1, 'month');
    this.loadHistories(dateFrom.toISOString(), dateTo.toISOString());
  },
  startNewEntry() {
    this.setState({
      currentEntry: {
        date: new Date(),
        debits:  [],
        credits: []
      }
    });
  },
  handleSave(data) {
    this.closeEntryModal();
    this.setState({ transactions: [data.data].concat(this.state.transactions) });
    this.info("登録しました。");
  },
  closeEntryModal() {
    this.setState({ currentEntry: null });
  },
  info(text) {
    this.setState({ notice: {type: "info", text: text} });
    setTimeout(() => this.setState({ notice: null }), 2000); // todo 別のnoticeが削除される可能性がある
  },
  error(text) {
    this.setState({ notice: {type: "danger", text: text} });
    setTimeout(() => this.setState({ notice: null }), 2000);
  },
  render() {
    var notice = (this.state.notice) && (<Notice type={this.state.notice.type}>{this.state.notice.text}</Notice>);

    return (
      <div>
        {notice}
        <NewEntryButtonForm onClick={this.startNewEntry}>登録</NewEntryButtonForm>
        <RecentHistory data={this.state.transactions}
                       dateFrom={this.state.transactionDateFrom}
                       loadFollowingHistories={this.loadFollowingHistories}
                       deleteTransaction={this.deleteTransaction}/>

        <EntryModal title="登録" url="api/transactions"
                    items={this.state.items}
                    editTarget={this.state.currentEntry}
                    show={this.state.currentEntry}
                    onSave={this.handleSave}
                    onCancel={this.closeEntryModal} />
      </div>
    );
  }
});
