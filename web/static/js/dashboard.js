import NewEntryButtonForm from "./new-entry-button-form"
import RecentHistroy from "./recent-history"

export default React.createClass({
    render(): any {
        return (
            <div>
                <NewEntryButtonForm />
                <RecentHistroy />
            </div>
        );
    }
});
