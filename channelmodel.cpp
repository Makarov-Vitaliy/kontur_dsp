#include "channelmodel.h"
#include <QDebug>

ChannelModel::ChannelModel(QObject *parent) : QAbstractListModel (parent)
{
	//TODO мулька
  updatePresets();
}

int ChannelModel::rowCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent)
	return m_channelList.count();
}

QVariant ChannelModel::data(const QModelIndex &index, int role) const
{
	int rowIndex = index.row();
	if (rowIndex<0 || rowIndex>=m_channelList.count()) {
		return QVariant();
		qWarning()<<"index out of range error";
	}

	switch (role) {
	case NameRole:
		return m_channelList[rowIndex].m_name;
		break;
	default:
		return QVariant();
		break;
	}
}

QHash<int, QByteArray> ChannelModel::roleNames() const
{
	QHash<int, QByteArray> t_roleNames;
	t_roleNames[NameRole] = "name";
	return t_roleNames;
}

void ChannelModel::updatePresets()
{

	m_channelList.clear();

	// Мулька для теста
	for (int i=0; i<10; ++i) {
		ChannelData preset("CH"+ QString::number(i+1));
		m_channelList.append(preset);
	}
}

void ChannelModel::set_channel_name(const int ind, const QString &name)
{
	if (m_channelList.length()<ind+1) return;
	else {
		m_channelList[ind].m_name=name;
		emit dataChanged(index(ind, 0), index(ind, 0));
	}
}
