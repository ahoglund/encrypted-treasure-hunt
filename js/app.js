import React from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';


class ClueForm extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault;
    console.log("A SUBMIT HAPPENED");
  }

  render() {
    return (
      <form className="form-inline" onSubmit={this.handleSubmit}>
        <div className="form-group col-sm-12">
          <label for={this.props.id} className="sr-only">Message</label>
          <textarea readOnly="true" id={this.props.id} value={this.props.message} />
        </div>
        <div className="form-group col-sm-12">
          <input type="text" className="form-control" id="inputKey" placeholder="A:B" />
          <button type="submit" className="btn btn-primary">Submit</button>
        </div>
      </form>
    );
  }
}

class EncryptedTreasureHunt extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      clues: []
    };
  }

  componentDidMount() {
    axios.get(`/hunt/${this.props.hunt}`)
      .then(response => {
        this.setState(()=> {
          return {
            clues: response.data
          }
        });
      });
  }

  render() {
    return (
      <div>
        <h1>Tresure Hunt {this.props.hunt}</h1>
        <ul>
          {this.state.clues.map((clue) =>
            <ClueForm key={clue.id} id={clue.id} message={clue.message}/>
          )}
        </ul>
      </div>
    );
  }
}

ReactDOM.render(<EncryptedTreasureHunt hunt="1" />,  document.getElementById("encrypted-treasure-hunt-app"));
