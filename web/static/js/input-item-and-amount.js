export default React.createClass({
    render() {
        return (
            <div className="form-group clearfix">
                <select className="form-control col-xs-8-form">
                    <option>費用：外食費</option>
                </select>
                <input className="form-control col-xs-4-form" type="number" placeholder="金額" style={{textAlign: "right"}}/>
            </div>
        );
    }
});
