import NewEntryButtonForm from "./new-entry-button-form"
import RecentHistory from "./recent-history"
import EntryModal from "./entry-modal"

export default React.createClass({
    getInitialState() {
        return {
            currentEntry: null
        };
    },
    startNewEntry() {
        this.setState({
            currentEntry: {
                date: new Date(),
                debits:  [],
                credits: []
            }
        });
    },
    handleSave(data) {
        console.log(data);
        this.closeEntryModal();
    },
    closeEntryModal() {
        this.setState({ currentEntry: null })
    },
    render() {
        return (
            <div>
                <NewEntryButtonForm onClick={this.startNewEntry}>登録</NewEntryButtonForm>
                <RecentHistory />

                <EntryModal title="登録" url="api/transactions"
                            editTarget={this.state.currentEntry}
                            show={this.state.currentEntry}
                            onSave={this.handleSave}
                            onCancel={this.closeEntryModal} />
            </div>
        );
    }
});
