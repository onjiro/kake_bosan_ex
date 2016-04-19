export default React.createClass({
  debits() {
    return _(this.props.data.entries || []).select((e) => e.side_id == 1);
  },
  credits() {
    return _(this.props.data.entries || []).select((e) => e.side_id == 2);
  },
  debitItems() {
    return _(this.debits(this.props.data).reduce((memo, e) => memo + e.item.name, ''));
  },
  creditItems() {
    return _(this.credits(this.props.data).reduce((memo, e) => memo + e.item.name, ''));
  },
  debitSum() {
    return _(this.debits(this.props.data).reduce((memo, e) => memo + e.amount, 0));
  },
  creditSum() {
    return _(this.credits(this.props.data).reduce((memo, e) => memo + e.amount, 0));
  },
  delete(e) {
    if (window.confirm("本当に削除してよろしいですか？")) {
      this.props.deleteTransaction(this.props.data);
    }
  },
  render() {
    return (
      <tr>
        <td>{moment(this.props.data.date).format('YYYY-MM-DD')}</td>
        <td>{this.debitItems(this.props.data)}</td>
        <td className="hidden-xs">&yen;{this.debitSum(this.props.data)}</td>
        <td>{this.creditItems(this.props.data)}</td>
        <td>&yen;{this.creditSum(this.props.data)}</td>
        <td><button type="button" className="delete-row pull-right" onClick={this.delete}>x</button></td>
      </tr>
    );
  }
});
