#ifndef MANAGER
#define MANAGER

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "presetmodel.h"
#include "channelmodel.h"
#include "localsettings.h"

class Manager : public QObject
{
     Q_OBJECT
public:
	explicit Manager(QQmlApplicationEngine *engine, QObject *parent = nullptr);
	void prepare();

private:
	 QQmlApplicationEngine* m_engine;
	 QScopedPointer<PresetModel> m_presetModel;
	 QScopedPointer<ChannelModel> m_channelModel;
	 QSharedPointer<LocalSettings> m_localSettings;

signals:

};

#endif // MANAGER
