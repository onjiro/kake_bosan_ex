export default React.createClass({
    handleCancel(e) {
        e.preventDefault();
        this.props.onCancel(e);
    },
    render() {
        return (
            <div className="modal" style={{display: (this.props.visible) ? "block": "none", backgroundColor: "rgba(0, 0, 0, 0.5)" }}>
                <div className="modal-dialog">
                     <div className="modal-content">
                         <div className="modal-header">
                             <button type="button" className="close" onClick={this.handleCancel}><span>&times;</span></button>
                             <h4>modal title</h4>
                         </div>
                         <div className="modal-body">
                         </div>
                         <div className="modal-footer">
                              <button type="button" className="btn btn-default" onClick={this.handleCancel}>キャンセル</button>
                              <button type="submit" className="btn btn-primary">OK</button>
                         </div>
                     </div>
                </div>
            </div>
        );
    }
});
