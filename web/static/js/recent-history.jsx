export default React.createClass({
  render() {
    var list =  this.props.data.map((transaction) => (
      <tr>
        <td>{transaction.date}</td>
        <td>todo</td>
        <td>&yen;{transaction.entries[0].amount}</td>
        <td>todo</td>
        <td>&yen;{transaction.entries[1].amount}</td>
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
