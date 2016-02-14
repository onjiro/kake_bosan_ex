export default React.createClass({
  render() {
    return (
      <nav className="navbar navbar-default" role="navigation">
        <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false">
          <span className="glyphicon glyphicon-menu-hamburger"></span>
        </button>

        <div className="nav navbar-header">
          <a className="navbar-brand" href="/"><span className="glyphicon glyphicon-home"></span> 家計簿さん</a>
        </div>

        <div className="collapse navbar-collapse" id="navbar-collapse">
          <ul className="nav navbar-nav navbar-right">
            <li className="current-user dropdown">
              <li className="active"><a href="#"><span className="glyphicon glyphicon-list-alt"></span> 履歴</a></li>
              <li><a href="#"><span className="glyphicon glyphicon-check"></span> 棚卸し</a></li>
            </li>
          </ul>
        </div>
      </nav>
    );
  }
});
