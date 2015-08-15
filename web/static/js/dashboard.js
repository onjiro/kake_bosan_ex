import NewEntryButtonForm from "./new-entry-button-form"
import RecentHistory from "./recent-history"
import EntryModal from "./entry-modal"

export default React.createClass({
    getInitialState() {
        return {
            showEntryModal: false,
        };
    },
    toggleEntryModal() {
        this.setState({showEntryModal: !this.state.showEntryModal})
    },
    render() {
        return (
            <div>
                <NewEntryButtonForm onClick={this.toggleEntryModal}>登録</NewEntryButtonForm>
                <RecentHistory />

                <EntryModal title="登録" visible={this.state.showEntryModal} onCancel={this.toggleEntryModal}/>
            </div>
        );
    }
});
