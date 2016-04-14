import NewEntryButtonForm from "./new-entry-button-form";
import RecentHistory from "./recent-history";
import EntryModal from "./entry-modal";

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
      $.ajax(`${this.props.url}/transactions`, { dataType: 'json', data: {
        dateFrom: dateFrom,
        dateTo:   dateTo
      } }),
      $.ajax(`${this.props.url}/items`       , { dataType: 'json' })
    ).then((trxRes, itemsRes) => {
      var currentTransactions = this.state.transactions;
      this.setState({
        transactionDateFrom: dateFrom,
        transactions:        currentTransactions.concat(trxRes[0].data),
        items:               itemsRes[0].data
      });
    }, (err) => {
      console.error(err);
    });
  },
  deleteTransaction(transaction) {
    $.ajax(`${this.props.url}/transactions/${transaction.id}`, {
      method: 'DELETE'
    }).then((data) => {
      this.setState("transactions", _(this.state.transactions).reject((one) => one.id === transaction.id));
    }).fail((err) => {
      console.error(err);
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
  },
  closeEntryModal() {
    this.setState({ currentEntry: null });
  },
  render() {
    return (
      <div>
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
