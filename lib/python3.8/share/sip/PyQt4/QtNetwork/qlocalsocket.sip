// qlocalsocket.sip generated by MetaSIP
//
// This file is part of the QtNetwork Python extension module.
//
// Copyright (c) 2018 Riverbank Computing Limited <info@riverbankcomputing.com>
// 
// This file is part of PyQt4.
// 
// This file may be used under the terms of the GNU General Public License
// version 3.0 as published by the Free Software Foundation and appearing in
// the file LICENSE included in the packaging of this file.  Please review the
// following information to ensure the GNU General Public License version 3.0
// requirements will be met: http://www.gnu.org/copyleft/gpl.html.
// 
// If you do not wish to use this file under the terms of the GPL version 3.0
// then you may purchase a commercial license.  For more information contact
// info@riverbankcomputing.com.
// 
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
// WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.


%If (Qt_4_4_0 -)

class QLocalSocket : QIODevice
{
%TypeHeaderCode
#include <qlocalsocket.h>
%End

public:
    enum LocalSocketError
    {
        ConnectionRefusedError,
        PeerClosedError,
        ServerNotFoundError,
        SocketAccessError,
        SocketResourceError,
        SocketTimeoutError,
        DatagramTooLargeError,
        ConnectionError,
        UnsupportedSocketOperationError,
%If (Qt_5_0_0 -)
        OperationError,
%End
        UnknownSocketError,
    };

    enum LocalSocketState
    {
        UnconnectedState,
        ConnectingState,
        ConnectedState,
        ClosingState,
    };

    QLocalSocket(QObject *parent /TransferThis/ = 0);
    virtual ~QLocalSocket();
%If (Qt_5_0_0 -)
    void connectToServer(const QString &name, QFlags<QIODevice::OpenModeFlag> mode = QIODevice::ReadWrite) /ReleaseGIL/;
%End
%If (- Qt_5_0_0)
    void connectToServer(const QString &name, QIODevice::OpenMode mode = QIODevice::ReadWrite) /ReleaseGIL/;
%End
    void disconnectFromServer() /ReleaseGIL/;
    QString serverName() const;
    QString fullServerName() const;
    void abort();
    virtual bool isSequential() const;
    virtual qint64 bytesAvailable() const;
    virtual qint64 bytesToWrite() const;
    virtual bool canReadLine() const;
    virtual void close();
    QLocalSocket::LocalSocketError error() const;
    bool flush();
    bool isValid() const;
    qint64 readBufferSize() const;
    void setReadBufferSize(qint64 size);
%If (Qt_5_0_0 -)
    bool setSocketDescriptor(qintptr socketDescriptor, QLocalSocket::LocalSocketState state = QLocalSocket::ConnectedState, QFlags<QIODevice::OpenModeFlag> mode = QIODevice::ReadWrite);
%End
%If (- Qt_5_0_0)
    bool setSocketDescriptor(quintptr socketDescriptor, QLocalSocket::LocalSocketState state = QLocalSocket::ConnectedState, QIODevice::OpenMode mode = QIODevice::ReadWrite);
%End
%If (Qt_5_0_0 -)
    qintptr socketDescriptor() const;
%End
%If (- Qt_5_0_0)
    quintptr socketDescriptor() const;
%End
    QLocalSocket::LocalSocketState state() const;
    virtual bool waitForBytesWritten(int msecs = 30000) /ReleaseGIL/;
    bool waitForConnected(int msecs = 30000) /ReleaseGIL/;
    bool waitForDisconnected(int msecs = 30000) /ReleaseGIL/;
    virtual bool waitForReadyRead(int msecs = 30000) /ReleaseGIL/;

signals:
    void connected();
    void disconnected();
    void error(QLocalSocket::LocalSocketError socketError);
    void stateChanged(QLocalSocket::LocalSocketState socketState);

protected:
    virtual SIP_PYOBJECT readData(qint64 maxlen) /TypeHint="Py_v3:bytes;str",ReleaseGIL/ [qint64 (char *, qint64)];
%MethodCode
        // Return the data read or None if there was an error.
        if (a0 < 0)
        {
            PyErr_SetString(PyExc_ValueError, "maximum length of data to be read cannot be negative");
            sipIsErr = 1;
        }
        else
        {
            char *s = new char[a0];
            qint64 len;
        
            Py_BEGIN_ALLOW_THREADS
        #if defined(SIP_PROTECTED_IS_PUBLIC)
            len = sipSelfWasArg ? sipCpp->QLocalSocket::readData(s, a0) : sipCpp->readData(s, a0);
        #else
            len = sipCpp->sipProtectVirt_readData(sipSelfWasArg, s, a0);
        #endif
            Py_END_ALLOW_THREADS
        
            if (len < 0)
            {
                Py_INCREF(Py_None);
                sipRes = Py_None;
            }
            else
            {
                sipRes = SIPBytes_FromStringAndSize(s, len);
        
                if (!sipRes)
                    sipIsErr = 1;
            }
        
            delete[] s;
        }
%End

    virtual qint64 writeData(const char * /Array, TypeHint="Py_v3:bytes;str"/, qint64 /ArraySize/) /ReleaseGIL/;

private:
    QLocalSocket(const QLocalSocket &);
};

%End
