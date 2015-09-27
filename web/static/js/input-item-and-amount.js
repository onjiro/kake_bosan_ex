export default React.createClass({
    handleItemChange(val) {
        this.props.onChange({
            id: this.props.data.id,
            item_id: val,
            amount: React.findDOMNode(this.refs.amount).value
        });
    },
    handleAmountChange(event) {
        this.props.onChange({
            id: this.props.data.id,
            item_id: this.props.data.item_id,
            amount: React.findDOMNode(this.refs.amount).value
        });
    },
    render() {
        return (
            <div className="account-line clearfix">
                <Select className="form-control col-xs-8-form" placeholder="科目"
                        options={ [{label: "費用: 外食費", value: 1}] } value={this.props.data.item_id}
                        onChange={this.handleItemChange} />
                <input className="form-control col-xs-4-form" placeholder="金額"
                       type="number" style={{textAlign: "right"}} value={this.props.data.amount}
                       ref="amount" onChange={this.handleAmountChange} />
            </div>
        );
    },
});
