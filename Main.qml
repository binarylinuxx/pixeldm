import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Item {
    width: 800
    height: 600

    // 1. Sharp Background (no blur)
    Image {
        id: background
        source: "background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    // 2. Login Box with Blur Effect
    Item {
        id: loginBox
        width: 500
        height: 400
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 50
        }

        // 3. Capture background section
        ShaderEffectSource {
            id: effectSource
            sourceItem: background
            sourceRect: Qt.rect(loginBox.x, loginBox.y, width, height)
            visible: false
        }

        // 4. Apply blur to captured section
        FastBlur {
            anchors.fill: parent
            source: effectSource
            radius: 48  // Strong blur effect
            transparentBorder: true
        }

        // 5. Content Container
        Rectangle {
            anchors.fill: parent
            radius: 20
            color: "#90000000"  // 90% opacity dark layer
            border.color: "#60FFFFFF"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 30
                spacing: 20

                // 6. Time Display
                Text {
                    id: timeText
                    color: "white"
                    font.pixelSize: 32
                    font.family: "JetBrains Mono"
                    Layout.alignment: Qt.AlignHCenter

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: timeText.text = Qt.formatDateTime(new Date(), "hh:mm AP")
                    }
                    Component.onCompleted: timeText.text = Qt.formatDateTime(new Date(), "hh:mm AP")
                }

                // 7. User Selection
                ComboBox {
                    id: userSelect
                    Layout.fillWidth: true
                    model: userModel
                    textRole: "name"
                    font.family: "JetBrains Mono"
                    font.pixelSize: 16
                    height: 50

                    background: Rectangle {
                        radius: 10
                        color: "#60FFFFFF"
                        border.color: "#80FFFFFF"
                    }
                }

                // 8. Password Field
                TextField {
                    id: passwordField
                    Layout.fillWidth: true
                    placeholderText: "Password"
                    echoMode: TextInput.Password
                    font.family: "JetBrains Mono"
                    height: 50
                    background: Rectangle {
                        radius: 10
                        color: "#60FFFFFF"
                        border.color: "#80FFFFFF"
                    }
                }

                // 9. Session Selector
                ComboBox {
                    id: sessionSelect
                    Layout.fillWidth: true
                    model: sessionModel
                    textRole: "name"
                    font.family: "JetBrains Mono"
                    height: 50
                    currentIndex: sessionModel.lastIndex

                    background: Rectangle {
                        radius: 10
                        color: "#60FFFFFF"
                        border.color: "#80FFFFFF"
                    }
                }

                // 10. Login Button
                Button {
                    Layout.fillWidth: true
                    text: "Login"
                    font.family: "JetBrains Mono"
                    font.pixelSize: 18
                    height: 50

                    background: Rectangle {
                        radius: 10
                        color: "#AA3b0905"
                        border.color: "#FF3b0905"
                    }

                    onClicked: sddm.login(userSelect.currentText, passwordField.text, sessionSelect.currentIndex)
                }
            }
        }
    }
}
