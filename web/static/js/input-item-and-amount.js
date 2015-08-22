export default React.createClass({
    render() {
        return (
            <div className="form-group clearfix">
                <Select className="form-control col-xs-8-form"
                        placeholder="科目"
                        options={ [{label: "費用: 外食費", value: 1}] }
                />
                <input className="form-control col-xs-4-form" type="number" placeholder="金額" style={{textAlign: "right"}}/>
            </div>
        );
    }
});
