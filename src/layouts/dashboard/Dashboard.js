import React, { Component } from 'react';
import Map from './components/Map';

class Dashboard extends Component {
  constructor(props, { authData }) {
    super(props)
    authData = this.props
  }

  render() {
    return(
      <main className="container">
        <div className="pure-g">
          <div className="pure-u-1-1">
            <h1>Dashboard</h1>
            <div><h3>User:</h3> {this.props.authData.name}</div>
            <Map />
          </div>
        </div>
      </main>
    )
  }
}

export default Dashboard
