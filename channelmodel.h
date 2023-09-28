#ifndef CHANNELMODEL_H
#define CHANNELMODEL_H

#include <QAbstractListModel>
#include <QObject>

class ChannelModel : public QAbstractListModel
{
	Q_OBJECT

	enum Roles {
		NameRole = Qt::UserRole + 1,
		Data1Role,
		Data2Role
	};

	struct ChannelData {
		ChannelData(QString name ):m_name(name){}
		ChannelData(){}
		QString m_name;
	};

public:
	explicit ChannelModel(QObject * parent = Q_NULLPTR);
	Q_INVOKABLE int rowCount(const QModelIndex &parent) const;
	QVariant data(const QModelIndex &index, int role) const;
	QHash<int, QByteArray> roleNames() const;
	void updatePresets();

public slots:
	void set_channel_name(const int ind, const QString & name);
private:
	 QList<ChannelData> m_channelList;
};

#endif // CHANNELMODEL_H
