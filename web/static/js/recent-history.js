export default React.createClass({
    render(): any {
        return (
            <div className="col-xs-12">
                <h4>直近７日間の履歴</h4>
                <section className="history row" style={{ minHeight: '320px'}}>
                    <table className="table" ng-show="history.initialized">
                        <thead>
                            <tr>
                                <th>{/* expands */}</th>
                                <th>日付</th>
                                <th>{/* separator */}</th>
                                <th>借方科目</th>
                                <th className="amount">借方金額</th>
                                <th>{/* separator */}</th>
                                <th>貸方科目</th>
                                <th className="amount">貸方金額</th>
                                <th>{/* separator */}</th>
                                <th>{/* controls */}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {/* todo */}
                        </tbody>
                    </table>
                </section>
            </div>
        )
    }
});
