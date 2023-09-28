#include "manager.h"

Manager::Manager(QQmlApplicationEngine *engine, QObject *parent) : QObject(parent)
{
	m_engine = engine;
	m_presetModel.reset(new PresetModel(this));
	m_channelModel.reset(new ChannelModel(this));
	m_localSettings = LocalSettings::instance();
}

void Manager::prepare() {
	QQmlContext *context = m_engine->rootContext();
	context->setContextProperty("presets", m_presetModel.data());
	context->setContextProperty("channels", m_channelModel.data());
	//m_presetModel
}
