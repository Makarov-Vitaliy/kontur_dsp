#include "presetmodel.h"
#include <QDebug>

PresetModel::PresetModel(QObject *parent) : QAbstractListModel (parent)
{
	//TODO мулька
  updatePresets();
}

int PresetModel::rowCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent)
	return m_presetsList.count();
}

QVariant PresetModel::data(const QModelIndex &index, int role) const
{
	int rowIndex = index.row();
	if (rowIndex<0 || rowIndex>=m_presetsList.count()) {
		return QVariant();
		qWarning()<<"index out of range error";
	}

	switch (role) {
	case NameRole:
		return m_presetsList[rowIndex].m_name;
		break;
	default:
		return QVariant();
		break;
	}
}

QHash<int, QByteArray> PresetModel::roleNames() const
{
	QHash<int, QByteArray> t_roleNames;
	t_roleNames[NameRole] = "name";
	return t_roleNames;
}

void PresetModel::updatePresets()
{

	m_presetsList.clear();

	// Мулька для теста
	for (int i=0; i<10; ++i){
		PresetsData preset("Preset "+ QString::number(i));
		m_presetsList.append(preset);
	}

}

void PresetModel::set_preset_name(const int ind, const QString &name)
{
	if (m_presetsList.length()<ind+1) return;
	else {
		m_presetsList[ind].m_name=name;
		emit dataChanged(index(ind, 0), index(ind, 0));
	}
}
