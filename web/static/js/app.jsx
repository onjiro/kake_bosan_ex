import {Socket} from "deps/phoenix/web/static/js/phoenix"
import "deps/phoenix_html/web/static/js/phoenix_html"
import Dashboard from "./dashboard"

$(function() {
  React.render(<Dashboard url="/api/transactions" />, document.getElementById('content'));
});
