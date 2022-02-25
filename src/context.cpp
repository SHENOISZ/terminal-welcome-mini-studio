#include "context.h"

Context::Context()
{

}

int Context::cursorX()
{
    QScreen *screen;

    for (QScreen *s : QGuiApplication::screens())
    {
        if (s)
            screen = s;
    }

    QPoint pos = QCursor::pos(screen);
    return pos.x();
}

int Context::cursorY()
{
    QScreen *screen;

    for (QScreen *s : QGuiApplication::screens())
    {
        if (s)
            screen = s;
    }

    QPoint pos = QCursor::pos(screen);
    return pos.y();
}

void Context::savesh(QString txt)
{
    QDir dir;
    QFile file(dir.homePath() + "/welcome_colors.sh");
    if (file.open(QFile::WriteOnly))
    {
        QTextStream tstream(&file);
        for (QString line : txt.split("<br>"))
        {
            tstream << line << endl;
        }
        file.close();
    }
}

/*
* https://stackoverflow.com/questions/2616906/how-do-i-output-coloured-text-to-a-linux-terminal
"\033[{FORMAT_ATTRIBUTE};{FORGROUND_COLOR};{BACKGROUND_COLOR}m{TEXT}\033[{RESET_FORMATE_ATTRIBUTE}m"
FORMAT ATTRIBUTE
 { "Default", "0" },
 { "Bold", "1" },
 { "Dim", "2" },
 { "Italics", "3"},
 { "Underlined", "4" },
 { "Blink", "5" },
 { "Reverse", "7" },
 { "Hidden", "8" }
FORGROUND COLOR
 { "Default", "39" },
 { "Black", "30" },
 { "Red", "31" },
 { "Green", "32" },
 { "Yellow", "33" },
 { "Blue", "34" },
 { "Magenta", "35" },
 { "Cyan", "36" },
 { "Light Gray", "37" },
 { "Dark Gray", "90" },
 { "Light Red", "91" },
 { "Light Green", "92" },
 { "Light Yellow", "93" },
 { "Light Blue", "94" },
 { "Light Magenta", "95" },
 { "Light Cyan", "96" },
 { "White", "97" }
BACKGROUND COLOR
 { "Default", "49" },
 { "Black", "40" },
 { "Red", "41" },
 { "Green", "42" },
 { "Yellow", "43" },
 { "Blue", "44" },
 { "Megenta", "45" },
 { "Cyan", "46" },
 { "Light Gray", "47" },
 { "Dark Gray", "100" },
 { "Light Red", "101" },
 { "Light Green", "102" },
 { "Light Yellow", "103" },
 { "Light Blue", "104" },
 { "Light Magenta", "105" },
 { "Light Cyan", "106" },
 { "White", "107" }
RESET FORMAT ATTRIBUTE
 { "All", "0" },
 { "Bold", "21" },
 { "Dim", "22" },
 { "Underlined", "24" },
 { "Blink", "25" },
 { "Reverse", "27" },
 { "Hidden", "28" }
 */

QStringList Context::rasterizer(int bg, QString code, QString path)
{
    int height = 26;
    QStringList add;
    QImage tmp(path.split("file://")[1]);
    QImage image = tmp.scaled(height * 4, height, Qt::IgnoreAspectRatio);
    QString text, text2;

    text2 += "printf \"";

    for (int h = 0; h < image.height(); h++)
    {
        for (int w = 0; w < image.width(); w++)
        {
            QColor color = image.pixelColor(w, h);

            if (color.alpha() <= 250)
            {
                text += "&nbsp;";
                text2 += " ";
            //black
            } else if (color.red() <= 33 && color.green() <= 33 && color.blue() <= 33)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#000\" style=\"background-color: #000;\">") + code + "</font>";
                    text2 += QString("\\033[40m\\033[30m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#000\">") + code + "</font>";
                    text2 += QString("\\033[30m") + code + "\\033[0m";
                }
            //gray
            /*
            } else if (color.red() > 33 && color.red() <= 66 && color.green() > 33 && color.green() <= 66 && color.blue() > 33 && color.blue() <= 66)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#333\" style=\"background-color: #333;\">") + code + "</font>";
                    text2 += QString("\\033[100m\\033[90m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#333\">") + code + "</font>";
                    text2 += QString("\\033[90m") + code + "\\033[0m";
                }
            */
            //white
            } else if (color.red() >= 172 && color.green() >= 172 && color.blue() >= 172)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#fff\" style=\"background-color: #fff;\">") + code + "</font>";
                    text2 += QString("\\033[107m\\033[97m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#fff\">") + code + "</font>";
                    text2 += QString("\\033[97m") + code + "\\033[0m";
                }
            //red
            } else if (color.red() >= 102 && color.green() <= 51 && color.blue() <= 51)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#f00\" style=\"background-color: #f00;\">") + code + "</font>";
                    text2 += QString("\\033[31m\\033[41m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#f00\">") + code + "</font>";
                    text2 += QString("\\033[41m") + code + "\\033[0m";
                }
            //green
            } else if (color.red() <= 60 && color.green() >= 102 && color.blue() <= 60)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#0f0\" style=\"background-color: #0f0;\">") + code + "</font>";
                    text2 += QString("\\033[42m\\033[32m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#0f0\">") + code + "</font>";
                    text2 += QString("\\033[32m") + code + "\\033[0m";
                }
            //blue
            } else if (color.red() <= 60 && color.green() <= 60 && color.blue() >= 102)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#00f\" style=\"background-color: #00f;\">") + code + "</font>";
                    text2 += QString("\\033[44m\\033[34m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#00f\">") + code + "</font>";
                    text2 += QString("\\033[34m") + code + "\\033[0m";
                }
            //purple
            } else if (color.red() >= 51 && color.green() <= 102 && color.blue() >= 102)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#ffff00\" style=\"background-color: #ffff00;\">") + code + "</font>";
                    text2 += QString("\\033[45m\\033[35m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#ffff00\">") + code + "</font>";
                    text2 += QString("\\033[35m") + code + "\\033[0m";
                }
            //magenta
            } else if (color.red() >= 102 && color.green() <= 51 && color.blue() >= 51)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#ffff00\" style=\"background-color: #ffff00;\">") + code + "</font>";
                    text2 += QString("\\033[105m\\033[95m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#ffff00\">") + code + "</font>";
                    text2 += QString("\\033[95m") + code + "\\033[0m";
                }
            //yellow
            } else if (color.red() >= 102 && color.green() >= 102 && color.blue() <= 53)
            {
                if (bg == 1) {
                    text += QString("<font color=\"#ffff00\" style=\"background-color: #ffff00;\">") + code + "</font>";
                    text2 += QString("\\033[43m\\033[33m") + code + "\\033[0m\\033[0m";
                } else {
                    text += QString("<font color=\"#ffff00\">") + code + "</font>";
                    text2 += QString("\\033[33m") + code + "\\033[0m";
                }
            //blank
            } else {
                text += "&nbsp;";
                text2 += " ";
            }
        }

        text += "<br>";
        text2 += "<br>";
    }

    text2 += "\"";
    //image.save("/home/shenoisz/Imagens/path229-2.png");
    add.append(text);
    add.append(text2);
    //qDebug() << text;
    return add;
}
