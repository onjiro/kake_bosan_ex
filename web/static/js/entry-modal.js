import Modal from "./modal"
import InputItemAndAmount from "./input-item-and-amount"

export default React.createClass({
    getInitialState() {
        return {
            debits:  [{ id: "debit0" , item: null, amount: null }],
            credits: [{ id: "credit0", item: null, amount: null }]
        };
    },
    handleCancel(e) {
        e.preventDefault();
        this.setState(this.getInitialState());
        this.props.onCancel(e);
    },
    handleChangeDebit(data) {
        var newDebits = this.state.debits;
        _.extend(_.findWhere(newDebits, { id: data.id }), data);

        if (_.last(this.state.debits).amount) {
            this.setState({ debits: newDebits.concat({ id: "debit" + newDebits.length, item: null, amount: null }) });
        } else {
            this.setState({ debits: newDebits });
        }
    },
    handleChangeCredit(data) {
        var newCredits = this.state.credits;
        _.extend(_.findWhere(newCredits, { id: data.id }), data);

        if (_.last(this.state.credits).amount) {
            this.setState({ credits: newCredits.concat({ id: "credit" + newCredits.length, item: null, amount: null }) });
        } else {
            this.setState({ credits: newCredits });
        }
    },
    render() {
        if (!this.props.show) return <div />;
        return (
            <Modal>
                <Modal.Header onHide={this.handleCancel}>
                    <h4>{this.props.title}</h4>
                </Modal.Header>
                <Modal.Body>
                  <form className="form form-inline">
                    <div className="form-group">
                      <div className="input-group">
                        <div className="input-group-addon"><span className="glyphicon glyphicon-time"></span></div>
                        <input className="form-control" type="date"
                               value={this.props.editTarget.date.toISOString().substring(0, 10)} />
                      </div>
                    </div>

                    <section>
                      <legend>借方</legend>
                      <div className="form-group">
                        {this.state.debits.map((one) => {
                            return <InputItemAndAmount data={one} onChange={this.handleChangeDebit}/>;
                        })}
                      </div>
                    </section>

                    <section>
                      <legend>貸方</legend>
                      <div className="form-group">
                        {this.state.credits.map((one) => {
                            return <InputItemAndAmount data={one} onChange={this.handleChangeCredit}/>;
                        })}
                      </div>
                    </section>
                  </form>
                </Modal.Body>
                <Modal.Footer>
                     <button type="button" className="btn btn-default" onClick={this.handleCancel}>キャンセル</button>
                     <button type="submit" className="btn btn-primary">OK</button>
                </Modal.Footer>
            </Modal>
        );
    }
});
