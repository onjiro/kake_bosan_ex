import {Socket} from "phoenix"
import Dashboard from "./dashboard"

$(function() {
    React.render(<Dashboard />, document.getElementById('content'));
});
