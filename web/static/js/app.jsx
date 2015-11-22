import {Socket} from "deps/phoenix/web/static/js/phoenix";
import "deps/phoenix_html/web/static/js/phoenix_html";
import Dashboard from "./dashboard";

$(() => React.render(<Dashboard url="/api" />, document.getElementById('content')));
