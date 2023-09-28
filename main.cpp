//#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "manager.h"
#include <QResource>
#include <QScreen>
#include <QApplication>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

	QApplication app(argc, argv);

	app.setOrganizationName("Kontur Studio");
	app.setOrganizationDomain("kontur-audio.ru");
	app.setApplicationName("KonturDSP");


#if defined(Q_OS_ANDROID)
	QScreen *srn = QGuiApplication::screens().at(0);
	 qreal dotsPerInch = (qreal)srn->devicePixelRatio();
	 if(dotsPerInch < 2)
	 {
		 QResource::registerResource("assets:/resources@1x.rcc");
	 }
	 else if(dotsPerInch < 3)
	 {
		 QResource::registerResource("assets:/resources@2x.rcc");
	 }
	 else
	 {
		 QResource::registerResource("assets:/resources@3x.rcc");
	 }
#else
	bool r=QResource::registerResource("../KonturDSP/out_rcc/resources@1x.rcc");
	qDebug()<<"REGESTER=="<<r;
#endif
	QQmlApplicationEngine engine;

	Manager *manager=new Manager(&engine);
	manager->prepare();

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

	return app.exec();
}
