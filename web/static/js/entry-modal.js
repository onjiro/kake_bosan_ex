import Modal from "./modal"
import InputItemAndAmount from "./input-item-and-amount"

export default React.createClass({
    getInitialState() {
        return {
            date: new Date(),
            debits:  [{ id: "debit0" , item: null, amount: null }],
            credits: [{ id: "credit0", item: null, amount: null }]
        };
    },
    handleCancel(e) {
        e.preventDefault();
        this.setState(this.getInitialState());
        this.props.onCancel(e);
    },
    handleSubmit(e) {
        e.preventDefault();
        $.ajax({
            url: this.props.url,
            dataType: "json",
            method: "POST",
            data: { transaction: {
                date: this.state.date.toISOString(),
                debits: this.state.debits,
                credits: this.state.credits
            }}
        }).done((data) => {
            this.props.onSave(data);
            this.setState(this.getInitialState());
        }).fail((xhr, status, err) => {
            console.error(this.props.url, status, err.toString());
        });
    },
    handleChangeDate() {
        var newVal = Date.parse(React.findDOMNode(this.refs.date).value);
        if (newVal) this.setState({ date: new Date(newVal) })
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
                <form className="form" onSubmit={this.handleSubmit}>
                  <Modal.Header onHide={this.handleCancel}>
                      <h4>{this.props.title}</h4>
                  </Modal.Header>
                  <Modal.Body>
                      <div className="form-group">
                        <div className="input-group">
                          <div className="input-group-addon"><span className="glyphicon glyphicon-time"></span></div>
                          <input className="form-control" type="date"
                                 value={this.state.date.toISOString().substring(0, 10)}
                                 onChange={this.handleChangeDate} ref="date" />
                        </div>
                      </div>
  
                      <section>
                        <legend>借方</legend>
                        <div className="form-group">
                          {this.state.debits.map((one) => {
                              return <InputItemAndAmount key={one.id} data={one} onChange={this.handleChangeDebit}/>;
                          })}
                        </div>
                      </section>
  
                      <section>
                        <legend>貸方</legend>
                        <div className="form-group">
                          {this.state.credits.map((one) => {
                              return <InputItemAndAmount key={one.id} data={one} onChange={this.handleChangeCredit}/>;
                          })}
                        </div>
                      </section>
                  </Modal.Body>
                  <Modal.Footer>
                       <button type="button" className="btn btn-default" onClick={this.handleCancel}>キャンセル</button>
                       <button type="submit" className="btn btn-primary">OK</button>
                  </Modal.Footer>
                </form>
            </Modal>
        );
    }
});
