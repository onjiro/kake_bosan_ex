export default React.createClass({
    render(): any {
        return (
            <div className="col-xs-12">
              <div className="btn-group btn-group-justified">
                <div className="btn-group">
                  <a className="btn btn-info btn-lg js-entry" href="#" onClick={this.hoge}><span className="glyphicon glyphicon-pencil"></span> 登録</a>
                </div>
              </div>
            </div>
        );
    }
});
