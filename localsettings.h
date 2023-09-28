#ifndef LOCALSETTINGS_H
#define LOCALSETTINGS_H

#include <QSharedPointer>
#include <QScopedPointer>
#include <QJsonValue>
#include <QObject>
#include <QSettings>

class LocalSettings : public QObject
{

	Q_OBJECT

public:

	static QSharedPointer<LocalSettings> instance();

	~LocalSettings();

	Q_INVOKABLE QVariant value(QString valueName);

	Q_INVOKABLE void setValue(QString valueName, QVariant newValue);

private:

	explicit LocalSettings();

	void createDefaultSettings();

	static QSharedPointer<LocalSettings> myself;

private:
	QScopedPointer<QSettings> m_settings;
};


#endif // LOCALSETTINGS_H


