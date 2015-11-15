export default React.createClass({
  debitItems(transaction) {
    return "todo";
  },
  creditItems(transaction) {
    return "todo";
  },
  debitSum(transaction) {
    return _.chain(transaction.entries)
      .select((e) => e.side_id == 1)
      .reduce((memo, e) => memo + e.amount, 0)
      .value();
  },
  creditSum(transaction) {
    return _.chain(transaction.entries)
      .select((e) => e.side_id == 2)
      .reduce((memo, e) => memo + e.amount, 0)
      .value();
  },
  render() {
    var list =  this.props.data.map((transaction) => (
      <tr>
        <td>{moment(transaction.date).format('YYYY-MM-DD')}</td>
        <td>{this.debitItems}</td>
        <td>&yen;{this.debitSum(transaction)}</td>
        <td>{this.creditItems}</td>
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
