import React from 'react';
import ChainContract from '../../../../build/contracts/Chain.json';
import store from '../../../store';

const contract = require('truffle-contract')
const API_KEY = 'AIzaSyCP0HfI8gJRtgyx993TbIsMAzfl2rG8vYQ';

const styleMap = {
    position: 'relative',
    float: 'left',
    marginRight: '5%'
};
const styleSideBar = {
    float:'left',
    width: '45%'
};
/**
 * @function Map
 * @param {object} props
 * @description React functional component
*/
class Map extends React.Component {

  constructor (props) {
    super(props);
    this.state = {
      chainName : '',
      creationTime: '',
      index: ''}
    this.getChain();
  }


  render() {
    return (
      <div>
        <SideBar chain={this.state}/>
        <div className='map' style={styleMap}>
          <iframe width="600" height="450" frameBorder="0"
          src={`https://www.google.com/maps/embed/v1/directions?origin=Salto+Uruguay&destination=Montevideo+Uruguay&waypoints=San%Jose+Uruguay&key=${API_KEY}`} allowFullScreen>
          </iframe>
    </div>
    </div>);
  }

  getChain() {

    let web3 = store.getState().web3.web3Instance
  
    // Double-check web3's status.
    if (typeof web3 !== 'undefined') {
  
      return function(dispatch) {
        // Using truffle-contract we create the authentication object.
        const chain = contract(ChainContract)
        chain.setProvider(web3.currentProvider)
  
        // Declaring this for later so we can chain functions on Authentication.
        var chainInstance;
  
        // Get current ethereum wallet.
        web3.eth.getCoinbase((error, coinbase) => {
          // Log errors, if any.
          if (error) {
            console.error(error);
          }
          
          chain.deployed().then(function(instance) {
            chainInstance = instance
  
            chainInstance.getChain(0,{from: coinbase}).then((result) => {  // Hardcoded value (to be changed)
              console.log('name',web3.toAscii(result[0]));
              this.setState({ chainName : web3.toAscii(result[0]),
              chainCreationTime : new Date(parseInt(result[1])*1000),
              index : result[2]});
  
            });
          });
      });
    }  

}
}
}

/**
 * @function SideBar
 * @description show useful information about the chain in general
*/
const SideBar = (props) => {

  return (<div style={styleSideBar}>
           <h3>Suppy Chain <Menu /></h3>
             Name         :  Suminitro Salto-Montevideo  <br/>
             Creation date:2017-01-30                    <br/>
           <h3>Shipment <Menu /></h3>  
             Origin           : Salto,Uruguay            <br/>
             Destination      : Montevideo,Uruguay       <br/>
             Current latitude : -34.338889               <br/>
             Current longitude: -56.710278               <br/>
             Weight           : 2360 (Kg)                <br/>
             Creation date    : 2017-01-30              <br/>
           <h3>Goods <Menu /></h3>                       <br/>
             Current owner    : 0x436004cd8a6210732dfa7253f73f00c349e3cdc9<br/>
           <h3>Property <Menu label="name"/></h3>
             Unit             : °C                   <br/>
             Value            : xxxx                  <br/>
             Updated          : 2018-01-14 00:00:00
             {setTimeout(() => alert('Upper threshold has been exceded. xxxx>th'),2000)}
         </div>);
    
}

const Menu = (props) => {
  let label = props.label;
  if(!label) {
    label = "#";
     return (
       <div>
      <label>{label}</label>
      <select id="state">
        <option key="1">1</option>
        <option key="2">2</option>
        <option key="3">3</option>
      </select>
      </div>
    );
  }else{
    return (
      <div>
      <label>{label}</label>
      <select id="state">
        <option key="Temp">Temperature</option>
        <option key="Hum">Humidity</option>
        <option key="Pres">Pressure</option>
      </select>
      </div>
    );

  }

}

export default Map;