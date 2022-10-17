# Crossbar.io and Wamp

## Usage

- `docker start <containerId> -a`
- `localhost:8080/info`
- use Host App to configure Realm/Router/... **???**
- Check config: `docker cp <containerId>:/node/.crossbar/config.json .`
- Run Subscriber
- Run Publisher

## Crossbar.io

- Crossbar.io is an open source networking platform for distributed and microservice applications.
- Crossbar.io is a multi process architecture.
- Crossbar.io is a WAMP router.
- Crossbar.io is an implementation of the open Web Application Messaging Protocol (WAMP).
- Crossbar.io is agnostic to the implementation of the client or its deployment.

Node

- A single instance of Crossbar.io is called **Crossbar.io node**, on start initially it starts a single process called **node controller**.
- The node controller reads the configuration file locally and starts multiple worker processes such as **router**, **containers** and guest workers.
  - Routers are the core facilities responsible for routing WAMP messages.
  - Containers are clients which runs natively as part of Crossbar.io.
  -
- [Getting Started](https://crossbar.io/docs/Getting-Started/)
- [DockerHub](https://hub.docker.com/r/crossbario/crossbar)

### Config

- Copy config from container to current path: `docker cp 5311ef863dad:/node/.crossbar/config.json .`

### Crossbario Semantics

- **Node** Controller
  - The node controller is the master process of everything. The node controller reads the configuration file locally and starts multiple worker processes such as router, containers and guest workers
- **Router**
  - Routers are the core facilities of Crossbar.io, responsible for routing WAMP remote procedure calls between Callers and Callees, as well as routing WAMP publish-subscribe events between Publishers and Subscribers.
  - To start a router the following things needs to be defined.
    - **Realm**
    - **Transport**
- **Realm**
  - is equivalent to a namespace. Crossbar.io uses realms as domains for separation of routing and administration
  - The router needs to provide at least one realm for applications to communicate through

- **Transport**
  - Transports are necessary for allowing incoming connections to Routers
  - Crossbar.io provides WebSocket and RawSocket Transport
  
---

## WAMP / WampSharp

- WAMP (*Web Application Messaging Protocol*) is a **WebSocket** subprotocol specified to offer Routed **[RPC](https://en.wikipedia.org/wiki/Remote_procedure_call)** and **[Publish–subscribe](<https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern>)** pattern.
- WAMP requires a full-duplex message channel as a transport layer, and by default uses Websocket.
- The minimum requirements to build a WAMP client are the abilities to use sockets and to serialise to JSON.
- A qualified WAMP client with basic profile should be able to do the following things
  - Subscribe to a topic (eg: com.myapp.hello)
  - Publish to a topic
  - Register a procedure (eg: com.myapp.date)
  - Call a procedure
- **WampSharp** is a .NET open source implementation of WAMP which allows you to write RPC services and Pub/Sub based applications.
- [WAMP](https://wamp-proto.org/)
- [repo](https://github.com/Code-Sharp/WampSharp)
- [Getting started](https://wampsharp.net/wamp2/getting-started-with-wampv2/)

WAMP (Web Application Messaging Protocol) is an open application level protocol that provides two messaging patterns:

- Remote Procedure Calls
  - <https://de.wikipedia.org/wiki/Remote_Procedure_Call>
- Publish & Subscribe
  - <https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern>

## Wamp Semantics

Pattern:

- **Caller**
  - A role that can *call* a remote procedure call registered by a Callee (using the `CALL` messages).
  - The caller can *receive* a response with a result or an error from the router (using the `RESULT/ERROR` message).
- **Callee**
  - A role that can *register* a remote procedure call to the route (using the `REGISTER/UNREGISTER` messages)
  - The callee’s procedure can *be invoked* by the router (using the `INVOCATION` message).
  - The callee can *respond* with a result or an error to the router (using the YIELD/ERROR message).
- **Subscriber**
  - A role that can subscribe to a WAMP realm’s topic.
  - The subscriber will be notified about events published to the topic by publishers.
- **Publisher**
  - A role that can publish events to a WAMP realm’s topic.

Basics:

- **Realm** ... A WAMP realm, can be thought as a domain, where uris are mapped to procedures/topics. [[docu](https://wampsharp.net/wamp2/getting-started-with-wampv2/#about-realms)]
- **Channel** ...
  - ...connects to a given realm (using address and realm-uri) of a router
  - ...represents a session to a WAMPv2 router
  - ... contains a property *RealmProxy*

- **Proxy** ...is a proxy to the router’s remote realm.
- **Services** of a proxy  **???**

- **Topics** [[link]](https://wampsharp.net/wamp1/server-pubsub-hosting-wampv1/#about-topics)
  - Topics are **rx Subjects**, that means that they are both **observable** and **observers**. That means you can both **subscribe** to them and send them messages.
  - **ReactiveX** ...  implementation of reactive programming (e.g. rxjs) [link](https://en.wikipedia.org/wiki/ReactiveX) [link rxjs](https://rxjs.dev/guide/overview)
- **Subject** ...sort of bridge or proxy [...]  acts both as an Observer and as an Observable [link](https://reactivex.io/documentation/subject.html)
  - Subject represents an object that is both an observable sequence as well as an observer.
  - `<T>` ...The type of the elements processed by the subject.

---

## Remarks

- RPC
- Websocket
- Pub/Sub pattern
- Message Broker
- Reactive Programming
