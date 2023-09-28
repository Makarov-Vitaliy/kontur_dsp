#include "localsettings.h"
#include <QFile>
#include <QDebug>

//TODO Уточнить, какие натройки помимо пресета будем хранить...


LocalSettings::LocalSettings()
{

	//createDefaultSettings();
	m_settings.reset( new QSettings("settings", QSettings::IniFormat));
}

void LocalSettings::createDefaultSettings()
{


}

LocalSettings::~LocalSettings()
{
}

QVariant LocalSettings::value(QString valueName)
{
	return m_settings->value(valueName);
}

void LocalSettings::setValue(QString valueName, QVariant newValue)
{
	m_settings->setValue(valueName, newValue);
}

QSharedPointer<LocalSettings> LocalSettings::instance()
{
	if (!myself){
		myself.reset(new LocalSettings);
		return myself;
	} else {
		return QSharedPointer<LocalSettings>(myself);
	}
}

QSharedPointer<LocalSettings> LocalSettings::myself;

