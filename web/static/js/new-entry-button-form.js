export default React.createClass({
    handleClick(e) {
        e.preventDefault();
        this.props.onClick(e);
    },
    render() {
        return (
            <div className="col-xs-12">
              <div className="btn-group btn-group-justified">
                <div className="btn-group">
                  <a className="btn btn-info btn-lg js-entry" href="#" onClick={this.handleClick}>
                    {this.props.children}&nbsp;
                    <span className="glyphicon glyphicon-pencil"></span>
                  </a>
                </div>
              </div>
            </div>
        );
    }
});
