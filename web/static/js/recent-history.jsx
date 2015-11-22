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
            <div className="btn btn-lg btn-default btn-block">
              <span clasName="glyphicon glyphicon-download"></span>続き(2015/07/16 〜 2015/06/16)
            </div>
          </div>
        </section>
      </div>
    );
  }
});
