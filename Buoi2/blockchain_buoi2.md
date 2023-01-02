<strong>What problem that blockchain solves?</strong>
<br>

<p>Blockchain solved problem when we tranfer a digital asset between two peer without an intermediary</p>
<strong>What is a node in blockchain ?</strong>
<br>

<p>A blockchain node is a device, usually a computer, that participates in a blockchain netword</p><br>
<strong>How does a blockchain node work ?</strong>
<br>
<p>The main role of blockchain node are boardcasting and validating transactions
</p>
<br>
<p>When a user submit a transaction , it is received by a node and then broadcasts it to the rest of the network. All the nodes the network check the transaction to make sure that sender has the funds available and is authorized to send them </p>
<br>
<p>The fact that every node verifies transactions helps secures the network. An invalid transactions could only be approved if 51% of the node confirmed it</p>
<br>
<p>After new transactions are validated by the nodes ,they are grouped into blocks. Each new block is added to the blockchain following the rules of its cosensus mechanism</p>
<br>
<strong>Types of nodes in blockchain</strong>
<br>
<ul>
<li>
<strong>Archival full nodes  </strong>
<p>Store the entire blockchain ledger , that means all the transactions from the begining to the most recent.This type of  node needs to have a large amount of memory avaible since blockchain can take up quite a bit of  space.</p>
</li>
<li>
<strong>Pruned full nodes  </strong>
<p>Has a set memory limit. It downloads the blockchain, and then it deletes blocks starting with the oldest. This process is known as pruning, and blocks aren't fully deleted since their metadata and sequence remain. After pruning, this node will hold the most recent blockchain transactions up to its limit</p>
</li>
<li>
<strong>Light nodes  </strong>
<p>Only dowloads adn stores block headers . </p>
</li>
<li>
<strong>Masternodes  </strong>
<p>is a type of full node that validate transactions and maintains a record of the blockchain, but it can't add block to the blockchain.</p>
</li>
<li>
<strong>Mining nodes  </strong>
<p>participates in the crytocurrency mining process. Mining nodes are selects based on the blockchain's consensus mechanism</p>
</li>
<li>
<strong>Authority nodes  </strong>
<p>is one that has been elected by organization or community managing a blockchain.It's found in blockchain that have a vetting process required to be a node.</p>
</li>
<li><strong>Staking nodes</strong></li>
<p>Locks up cryptocurrency funds as collateral, </p>
<li>
<strong>Lighting nodes  </strong>
<p>create a separate network for users to connect off the blockchain , enabling off-chain transactions . The transaction are processed and then submitted to the main blockchain.Lighting nodes are useful on congested blockchain networks with slow processing and high transaction fees. These nodes allow for low-cost , near-instantaneous transactions. </p>
<br>
</li>
</ul>

<strong>How to create nodes in blockchain ?</strong>
<br>

<p>1. Get the appropriate node hardware. You can set up a node on you computer , but it can affect performance , it need to run in dedicated devices.</p>
<br>
<p>2. Download the blockchain node software and install it on yor machine.</p>
<br>
<p>3. Run the software every day . You don't need to run it all day, but the blockchain may have minimum requirement.</p>
<br>
<strong>How nodes in blockchain communicate ? </strong>
<p>The protocol is used to connect each other is called : “Gossip protocol”.  </p>
<p>It uses peer-to-peer network, where each node in the network communicates directly with other nodes.Most blockchain networks use a broadcast system where, if a node has five peers, every message that is received from one is sent to the other four. This way, messages percolate across the network over many paths, and no one has complete control over communications.</p>
<br>
<p>A node will broadcast data to neighboring nodes, and those nodes continue to broadcast to their neighboring nodes, and so on, and so forth until all nodes in the network have received the data. This peer-to-peer network of nodes is the core layer of blockchain architecture. </p>
<strong>References</strong>
<ul>
<li>https://www.fool.com/investing/stock-market/market-sectors/financials/blockchain-stocks/blockchain-node/#:~:text=A%20blockchain%20node%20is%20a,more%20decentralized%20the%20network%20is.</li>

<li>https://blog.aicpa.org/2018/02/blockchain-was-made-to-solve-1-problem-heres-what-that-is.html#sthash.15DQ1ddQ.QByWAHc7.dpbs</li>
<li>https://coin98.net/what-is-a-node</li>
<li>https://timesofindia.indiatimes.com/business/cryptocurrency/blockchain/what-are-blockchain-nodes/articleshow/88116308.cms</li>
</ul>
