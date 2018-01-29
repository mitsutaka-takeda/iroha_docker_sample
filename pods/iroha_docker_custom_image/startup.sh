#!/bin/bash

IROHA_STATUS=/tmp/iroha-status/started
IROHA_CONF_DIR=/tmp/iroha-config
NODE_CONF_DIR=/opt/iroha/config
NODE_TEMP_DIR=/opt/iroha/template
IROHAD=/opt/iroha/bin/irohad
IROHA_CLI=/opt/iroha/bin/iroha-cli

if [ -e "$IROHA_CONF_DIR/$NODE_NAME.pub" ]; then
    # テンプレートがあるのでそれを利用
    cp $IROHA_CONF_DIR/$NODE_NAME.pub $NODE_CONF_DIR/node.pub
    cp $IROHA_CONF_DIR/$NODE_NAME.priv $NODE_CONF_DIR/node.priv
else
    # 新しい鍵ペア生成
    if [ -e "$IROHA_CONF_DIR/node.pub" ]; then
        # 存在している場合は何もしない
        echo "$IROHA_CONF_DIR/node.pub is already exists."
    else
        $IROHA_CLI --new_account --name $NODE_CONF_DIR/node
    fi
fi

/bin/sleep 20
sed -e "s/NODE_NAME/$NODE_NAME/g" $NODE_TEMP_DIR/config.sample > $NODE_CONF_DIR/config.conf

if [ -e "$IROHA_STATUS" ]; then
    # 既に一度起動している場合はgenesis_blockは無しで起動
    echo "This node is already initialized node. Start up normal mode."
    $IROHAD \
        --config $NODE_CONF_DIR/config.conf \
        --keypair_name $NODE_CONF_DIR/node
else
    # まだ一度も起動していない場合はgenesis_blockつけて起動
    echo 1 > $IROHA_STATUS
    echo "This node is first time running node. Start up initialize mode."
    echo "Read /tmp/iroha-config/genesis.block."
    $IROHAD \
        --config $NODE_CONF_DIR/config.conf \
        --keypair_name $NODE_CONF_DIR/node \
        --genesis_block $IROHA_CONF_DIR/genesis.block
fi

