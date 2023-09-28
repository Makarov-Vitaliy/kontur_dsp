#ifndef PRESETMODEL_H
#define PRESETMODEL_H

#include <QAbstractListModel>

class PresetModel : public QAbstractListModel {

	Q_OBJECT

	enum Roles {
		NameRole = Qt::UserRole + 1,
		Data1Role,
		Data2Role
	};

	struct PresetsData {
		PresetsData(QString name ):m_name(name){}
		PresetsData(){}
		QString m_name;

	};

public:
	explicit PresetModel(QObject * parent = Q_NULLPTR);
	Q_INVOKABLE int rowCount(const QModelIndex &parent) const;
	QVariant data(const QModelIndex &index, int role) const;
	QHash<int, QByteArray> roleNames() const;
	void updatePresets();

public slots:
	void set_preset_name(const int ind, const QString & name);
private:
	 QList<PresetsData> m_presetsList;
};

#endif // PRESETMODEL_H
