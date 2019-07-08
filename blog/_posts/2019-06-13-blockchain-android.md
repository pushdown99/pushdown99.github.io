---
layout: post
title: 'Blockchain-Android' 
author: haeyeon.hwang
tags: [blockchain]
image: /assets/img/blog/hackathon.png
hide_image: true
---

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## Learning Site Address
https://gitlab.com/teameverywhere-public/voteapp
https://gitlab.com/teameverywhere-public/android/tree/final
https://steemit.com/kr/@wonsama/kr-dev-ipfs
https://github.com/maheshmurthy/ethereum_voting_dapp



---

## Source Code

### Build Gradle (module)
~~~java
compileOptions {
    sourceCompatibility JavaVersion.VERSION_1_8
    targetCompatibility JavaVersion.VERSION_1_8
}

// dependencies
implementation 'org.web3j:core:4.1.0-android'

~~~

~~~java
web3 = Web3j.build(new HttpService("https://ropsten.infura.io/v3/a083e681e1df47fcafb3c448f6bd4ec1"));
    try {
        Web3ClientVersion clientVersion = web3.web3ClientVersion().sendAsync().get();
        if(!clientVersion.hasError()){
        //  toastAsync("Connected!");
        }
        else {
        //  toastAsync(clientVersion.getError().getMessage());
        }
    } catch (Exception e) {
        //  toastAsync(e.getMessage());
    }
Toast.makeText(MainActivity.this, "Connected", Toast.LENGTH_LONG).show();
~~~

~~~java
public void toastAsync(String message) {
    runOnUiThread(() -> {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show();
        Log.d(TAG, "toastAsync: "+message);
    });
}
~~~

~~~xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
   xmlns:app="http://schemas.android.com/apk/res-auto"
   xmlns:tools="http://schemas.android.com/tools"
   android:layout_width="match_parent"
   android:layout_height="match_parent"
   android:orientation="vertical"

   tools:context=".MainActivity">

   <Button
       android:id="@+id/btnConnect"
       android:layout_width="match_parent"
       android:layout_height="wrap_content"
       android:text="Connect Ethereum Network"
        />

   <Button
       android:id="@+id/btnGetAddress"
       android:layout_width="match_parent"
       android:layout_height="wrap_content"
       android:text="Get Adress"
       />
</LinearLayout>
~~~

~~~java
public class MainActivity extends AppCompatActivity {
   private static final String TAG = "MainActivity";

   Web3j web3;

   @Override
   protected void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       setContentView(R.layout.activity_main);


       Button btnConnect = (Button)findViewById(R.id.btnConnect);
       btnConnect.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View v) {
               // 함수 호출
               Log.d(TAG, "btnConnect onClicked");
               web3 = Web3j.build(new HttpService("https://ropsten.infura.io/v3/a083e681e1df47fcafb3c448f6bd4ec1"));
               try {
                   Web3ClientVersion clientVersion = web3.web3ClientVersion().sendAsync().get();
                   if(!clientVersion.hasError()){
                       toastAsync("Connected!");
                   }
                   else {
                       toastAsync(clientVersion.getError().getMessage());
                   }
               } catch (Exception e) {
//                    toastAsync(e.getMessage());
               }
           }
       });
   }


   public void toastAsync(String message) {
       runOnUiThread(() -> {
           Toast.makeText(this, message, Toast.LENGTH_LONG).show();
           Log.d(TAG, "toastAsync: "+message);
       });
   }
}
~~~

~~~java
public class MainActivity extends AppCompatActivity {
   private static final String TAG = "MainActivity";

   Web3j web3;
   Credentials credentials;

   @Override
   protected void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       setContentView(R.layout.activity_main);


       Button btnConnect = (Button)findViewById(R.id.btnConnect);
       btnConnect.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View v) {
               // 함수 호출
               Log.d(TAG, "btnConnect onClicked");
               web3 = Web3j.build(new HttpService("https://ropsten.infura.io/v3/a083e681e1df47fcafb3c448f6bd4ec1"));
               try {
                   Web3ClientVersion clientVersion = web3.web3ClientVersion().sendAsync().get();
                   if(!clientVersion.hasError()){
                       toastAsync("Connected!");
                   }
                   else {
                       toastAsync(clientVersion.getError().getMessage());
                   }
               } catch (Exception e) {
//                    toastAsync(e.getMessage());
               }
           }
       });

       Button btnGetAddress = (Button) findViewById(R.id.btnGetAddress);
       btnGetAddress.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View v) {
               Log.d(TAG, "btnGetAddress onClicked");
               try {
//            Credentials credentials = WalletUtils.loadCredentials(password, new File(walletPath+"/"+fileName));
                   credentials = getCredentailFromPrivteKey("D581A513DBB0E0755E10FEFEB8B327DEA393A87EC500A51AC8EE34755DF87D4F");

                   toastAsync("Your address is " + credentials.getAddress());
                   Log.d(TAG, "getAddress: "+ credentials.getAddress());
                   Log.d(TAG, "getAddress: 0xA80c982364EF3f146266bec9d7E2F2b30CD94aF9");


               }
               catch (Exception e){

                   toastAsync("getAddress error "+e.getMessage());
               }

           }
       });
   }

   private Credentials getCredentailFromPrivteKey(String privateKeyInHex) {
       BigInteger privateKeyInBT = new BigInteger(privateKeyInHex, 16);
       ECKeyPair aPair = ECKeyPair.create(privateKeyInBT);
       Credentials aCredential = Credentials.create(aPair);
       return aCredential;
   }

   public void toastAsync(String message) {
       runOnUiThread(() -> {
           Toast.makeText(this, message, Toast.LENGTH_LONG).show();
           Log.d(TAG, "toastAsync: "+message);
       });
   }
}
~~~

## Layouts (Activity Main)

~~~xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
   xmlns:app="http://schemas.android.com/apk/res-auto"
   xmlns:tools="http://schemas.android.com/tools"
   android:layout_width="match_parent"
   android:layout_height="match_parent"
   android:orientation="vertical"

   tools:context=".MainActivity">

   <Button
       android:id="@+id/btnConnect"
       android:layout_width="match_parent"
       android:layout_height="wrap_content"
       android:text="Connect Ethereum Network"
        />

   <Button
       android:id="@+id/btnGetAddress"
       android:layout_width="match_parent"
       android:layout_height="wrap_content"
       android:text="Get Adress"
       />
</LinearLayout>
~~~

## Main Activity

~~~java
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.kenai.jffi.Main;

import org.web3j.crypto.Credentials;
import org.web3j.crypto.ECKeyPair;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.response.Web3ClientVersion;
import org.web3j.protocol.http.HttpService;

import java.math.BigInteger;


public class MainActivity extends AppCompatActivity {
   private static final String TAG = "MainActivity";

   Web3j web3;
   Credentials credentials;

   @Override
   protected void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       setContentView(R.layout.activity_main);


       Button btnConnect = (Button)findViewById(R.id.btnConnect);
       btnConnect.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View v) {
               // 함수 호출
               Log.d(TAG, "btnConnect onClicked");
               web3 = Web3j.build(new HttpService("https://ropsten.infura.io/v3/a083e681e1df47fcafb3c448f6bd4ec1"));
               try {
                   Web3ClientVersion clientVersion = web3.web3ClientVersion().sendAsync().get();
                   if(!clientVersion.hasError()){
                       toastAsync("Connected!");
                   }
                   else {
                       toastAsync(clientVersion.getError().getMessage());
                   }
               } catch (Exception e) {
//                    toastAsync(e.getMessage());
               }
           }
       });

       Button btnGetAddress = (Button) findViewById(R.id.btnGetAddress);
       btnGetAddress.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View v) {
               Log.d(TAG, "btnGetAddress onClicked");
               try {
//            Credentials credentials = WalletUtils.loadCredentials(password, new File(walletPath+"/"+fileName));
                   credentials = getCredentailFromPrivteKey("D581A513DBB0E0755E10FEFEB8B327DEA393A87EC500A51AC8EE34755DF87D4F");

                   toastAsync("Your address is " + credentials.getAddress());
                   Log.d(TAG, "getAddress: "+ credentials.getAddress());
                   Log.d(TAG, "getAddress: 0xA80c982364EF3f146266bec9d7E2F2b30CD94aF9");


               }
               catch (Exception e){

                   toastAsync("getAddress error "+e.getMessage());
               }

           }
       });
   }

   private Credentials getCredentailFromPrivteKey(String privateKeyInHex) {
       BigInteger privateKeyInBT = new BigInteger(privateKeyInHex, 16);
       ECKeyPair aPair = ECKeyPair.create(privateKeyInBT);
       Credentials aCredential = Credentials.create(aPair);
       return aCredential;
   }



   public void toastAsync(String message) {
       runOnUiThread(() -> {
           Toast.makeText(this, message, Toast.LENGTH_LONG).show();
           Log.d(TAG, "toastAsync: "+message);
       });
   }
}
~~~


backup
~~~xml
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello World!"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintRight_toRightOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</android.support.constraint.ConstraintLayout>
~~~

## Manifest

~~~xml
<uses-permission android:name="android.permission.INTERNET"/>
~~~

## Using Infura Endpoint

https://infura.io/
~~~java
web3 = ... HtpServer(...)
~~~


