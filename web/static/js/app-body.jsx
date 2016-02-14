import Dashboard from "./dashboard";

export default React.createClass({
  render() {
    return (
      <div className="container-fluid">
        <section className="content row">
          <Dashboard url="/api" />
        </section>
      </div>
    );
  }
});
