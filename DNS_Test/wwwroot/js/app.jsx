class ClickButton extends React.Component {

    constructor(props) {
        super(props);
        this.state = { class: "off", label: "Нажми" };

        this.press = this.press.bind(this);

        console.log("constructor");
    }
    componentWillReceiveProps(nextProps) {
        console.log("componentWillReceiveProps()");
    }
    componentWillMount() {
        console.log("componentWillMount()");
    }
    componentDidMount() {
        console.log("componentDidMount()");
    }
    componentWillUnmount() {
        console.log("componentWillUnmount()");
    }
    shouldComponentUpdate() {
        console.log("shouldComponentUpdate()");
        return true;
    }
    componentWillUpdate() {
        console.log("componentWillUpdate()");
    }
    componentDidUpdate() {
        console.log("componentDidUpdate()");
    }
    press() {
        var className = (this.state.class === "off") ? "on" : "off";
        this.setState({ class: className });
    }
    render() {
        console.log("render()");
        return <button onClick={this.press} className={this.state.class}>{this.state.label}</button>;
    }
}
ReactDOM.render(
    <ClickButton />,
    document.getElementById("content")
)