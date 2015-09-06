import NewEntryButtonForm from "./new-entry-button-form"
import RecentHistory from "./recent-history"
import EntryModal from "./entry-modal"

export default React.createClass({
    getInitialState() {
        return {
            currentEntry: null
        };
    },
    /* 新規登録を開始する */
    startNewEntry() {
        this.setState({
            currentEntry: {
                date: new Date(),
                debits:  [],
                credits: []
            }
        });
    },
    /* 登録モーダルを閉じる */
    closeEntryModal() {
        this.setState({ currentEntry: null })
    },
    render() {
        return (
            <div>
                <NewEntryButtonForm onClick={this.startNewEntry}>登録</NewEntryButtonForm>
                <RecentHistory />

                <EntryModal title="登録"
                            editTarget={this.state.currentEntry}
                            show={this.state.currentEntry}
                            onCancel={this.closeEntryModal}/>
            </div>
        );
    }
});
