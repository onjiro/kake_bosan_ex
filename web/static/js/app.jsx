import {Socket} from "deps/phoenix/web/static/js/phoenix";
import "deps/phoenix_html/web/static/js/phoenix_html";

import AppHeader from "./app-header";
import Dashboard from "./dashboard";
import Inventories from "./inventories";
var { Router, Route, IndexRoute, Link, browserHistory } = ReactRouter;

let App = React.createClass({
  render() {
    return (
      <div>
        <AppHeader />
        <div className="container-fluid">
          <section className="content row">
            {this.props.children}
          </section>
        </div>
      </div>
    );
  }
});

ReactDOM.render(
  <Router history={browserHistory}>
    <Route path="/" component={App} url="/api">
      <IndexRoute component={Dashboard} />
      <Route path="/inventories" component={Inventories} />
    </Route>
  </Router>, document.getElementById("root"));
