import React, { Component } from 'react';
import { WebView } from 'react-native-webview';
import { KeyboardAvoidingView } from 'react-native';

export default class MyWeb extends Component {
  render() {
    return (
      <KeyboardAvoidingView
        behavior="padding"
        enabled
        style={{ flex: 1 }}
      >
        <WebView
          source={{ uri: 'https://uat-uiaas-v2.synapsefi.com/synapse-chatbot?publicKey=[SYNAPSE_PUBLIC_KEY]&userId=[SYNAPSE_USER_ID]&isWebView=true&defaultPath=BANK_LOGINS&env=UAT&fp=[SYNAPSE_FP]' }}
          javaScriptEnabled
          domStorageEnabled
          startInLoadingState
        />
      </KeyboardAvoidingView>
    );
  }
}
