#ifndef CONTEXT_H
#define CONTEXT_H

#include <QObject>
#include <QGuiApplication>
#include <QScreen>
#include <QDir>
#include <QPoint>
#include <QCursor>
#include <QImage>
#include <QString>
#include <QStringList>
#include <QFile>
#include <QTextStream>
#include <QDebug>


class Context : public QObject
{
    Q_OBJECT
public:
    Context();
    Q_INVOKABLE int cursorX();
    Q_INVOKABLE int cursorY();
    Q_INVOKABLE void savesh(QString txt);
    Q_INVOKABLE QStringList rasterizer(int bg, QString code, QString path);
};

#endif // CONTEXT_H
