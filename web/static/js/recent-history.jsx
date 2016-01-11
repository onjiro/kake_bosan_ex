export default React.createClass({
  debits(transaction) {
    return _(transaction.entries || []).select((e) => e.side_id == 1);
  },
  credits(transaction) {
    return _(transaction.entries || []).select((e) => e.side_id == 2);
  },
  debitItems(transaction) {
    return _(this.debits(transaction).reduce((memo, e) => memo + e.item.name, ''));
  },
  creditItems(transaction) {
    return _(this.credits(transaction).reduce((memo, e) => memo + e.item.name, ''));
  },
  debitSum(transaction) {
    return _(this.debits(transaction).reduce((memo, e) => memo + e.amount, 0));
  },
  creditSum(transaction) {
    return _(this.credits(transaction).reduce((memo, e) => memo + e.amount, 0));
  },
  toBeLoadedRange() {
    var to   = moment(this.props.dateFrom).subtract(1, 'days').format("YYYY/MM/DD");
    var from = moment(this.props.dateFrom).subtract(1, 'month').format("YYYY/MM/DD");
    return `${to} 〜 ${from}`;
  },
  loadFollowingHistories(e) {
    e.preventDefault();
    this.props.loadFollowingHistories();
  },
  render() {
    var list =  this.props.data.map((transaction) => (
      <tr>
        <td>{moment(transaction.date).format('YYYY-MM-DD')}</td>
        <td>{this.debitItems(transaction)}</td>
        <td>&yen;{this.debitSum(transaction)}</td>
        <td>{this.creditItems(transaction)}</td>
        <td>&yen;{this.creditSum(transaction)}</td>
        <td></td>
      </tr>
    ));

    return (
      <div className="col-xs-12">
        <h4>直近７日間の履歴</h4>
        <section className="history row" style={{ minHeight: '320px'}}>
          <table className="table" ng-show="history.initialized">
            <thead>
              <tr>
                <th>日付</th>
                <th>借方科目</th>
                <th className="amount">借方金額</th>
                <th>貸方科目</th>
                <th className="amount">貸方金額</th>
                <th>{/* controls */}</th>
              </tr>
            </thead>
            <tbody>
              {list}
            </tbody>
          </table>
          <div className="col-xs-12">
            <a className="btn btn-lg btn-default btn-block" href="#" onClick={this.loadFollowingHistories}>
              <span clasName="glyphicon glyphicon-download"></span>続き({this.toBeLoadedRange()})
            </a>
          </div>
        </section>
      </div>
    );
  }
});
