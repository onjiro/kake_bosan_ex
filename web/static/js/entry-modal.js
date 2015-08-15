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
                             <h4>{this.props.title}</h4>
                         </div>
                         <div className="modal-body">
                           <form className="form form-inline">
                             <div className="form-group">
                               <div className="input-group">
                                 <div className="input-group-addon"><span className="glyphicon glyphicon-time"></span></div>
                                 <input className="form-control" type="date" value={this.props.date} />
                               </div>
                             </div>

                             <legend>借方</legend>
                             <div className="form-group">
                               <select className="form-control">
                                 <option>費用：外食費</option>
                               </select>
                               <div className="input-group">
                                 <div className="input-group-addon">&yen;</div>
                                 <input className="form-control" type="number" placeholder="借方金額" style={{textAlign: "right"}}/>
                               </div>
                               <div className="btn btn-default btn-block">
                                 <span className="glyphicon glyphicon-plus"></span> 行を追加
                               </div>
                             </div>

                             <legend>貸方</legend>
                             <div className="form-group">
                               <select className="form-control">
                                 <option>費用：外食費</option>
                               </select>
                               <div className="input-group">
                                 <div className="input-group-addon">&yen;</div>
                                 <input className="form-control" type="number" placeholder="借方金額" style={{textAlign: "right"}}/>
                               </div>
                               <div className="btn btn-default btn-block">
                                 <span className="glyphicon glyphicon-plus"></span> 行を追加
                               </div>
                             </div>
                           </form>
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
