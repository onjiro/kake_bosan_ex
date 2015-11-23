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
    $.when(
      $.ajax(`${this.props.url}/transactions`, { dataType: 'json', data: {
        dateFrom: dateFrom,
        dateTo:   dateTo
      } }),
      $.ajax(`${this.props.url}/items`       , { dataType: 'json' })
    ).then((trxRes, itemsRes) => {
      this.setState({
        transactionDateFrom: dateFrom,
        transactions:        trxRes[0].data,
        items:               itemsRes[0].data
      });
    }, (err) => {
      console.log(err);
    });
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
                       dateFrom={this.state.transactionDateFrom} />

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
