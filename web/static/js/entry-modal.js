import Modal from "./modal"
import InputItemAndAmount from "./input-item-and-amount"

export default React.createClass({
    handleCancel(e) {
        e.preventDefault();
        this.props.onCancel(e);
    },
    render() {
        return (
            <Modal show={this.props.show}>
                <Modal.Header onHide={this.handleCancel}>
                    <h4>{this.props.title}</h4>
                </Modal.Header>
                <Modal.Body>
                  <form className="form form-inline">
                    <div className="form-group">
                      <div className="input-group">
                        <div className="input-group-addon"><span className="glyphicon glyphicon-time"></span></div>
                        <input className="form-control" type="date" value={this.props.date} />
                      </div>
                    </div>

                    <section>
                      <legend>借方</legend>
                      <InputItemAndAmount />
                    </section>

                    <section>
                      <legend>貸方</legend>
                      <InputItemAndAmount />
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
