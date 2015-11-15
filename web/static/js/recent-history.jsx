export default React.createClass({
  render(): any {
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
              {this.props.data.map((transaction) => {
                  <tr>
                      <td>2015-08-15</td>
                        <td>外食費</td>
                          <td>&yen;630</td>
                            <td>現金</td>
                              <td>&yen;630</td>
                                <td></td>
                    </tr>
                  })}
                  <tr>
                    <td>2015-08-15</td>
                    <td>外食費</td>
                    <td>&yen;630</td>
                    <td>現金</td>
                    <td>&yen;630</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>2015-08-13</td>
                    <td>遊興費</td>
                    <td>&yen;1,016</td>
                    <td>DCカード</td>
                    <td>&yen;1,016</td>
                    <td></td>
                  </tr>
            </tbody>
          </table>
          <div className="col-xs-12">
            <div className="btn btn-lg btn-default btn-block">
              <span clasName="glyphicon glyphicon-download"></span>続き(2015/07/16 〜 2015/06/16)
            </div>
          </div>
        </section>
      </div>
    )
  }
});
