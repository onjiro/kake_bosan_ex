import {Socket} from "deps/phoenix/web/static/js/phoenix";
import "deps/phoenix_html/web/static/js/phoenix_html";

import AppHeader from "./app-header";
import AppBody from "./app-body";

let App = React.createClass({
  render() {
    return (
      <div>
        <AppHeader />
        <AppBody />
      </div>
    );
  }
});

$(() => React.render(<App url="/api" />, document.body));
