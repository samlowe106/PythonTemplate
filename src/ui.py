from PySide6.QtWidgets import (
    QWidget,
)


class UserInterface(QWidget):
    def __init__(self, width=800, height=600):
        super().__init__()

        self.resize(width, height)
        self.setWindowTitle("Python Program")

        # self.image_ui_element = QLabel()
        # self.image_ui_element.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)

    def resizeEvent(self, event):
        """
        Override the resizeEvent to rescale UI elements when the window is resized.
        """

        # Example: rescaling an image in a QLabel
        # pixmap = QPixmap(image_path)
        # scaled = pixmap.scaled(
        #    self.image_ui_element.size(), Qt.KeepAspectRatio, Qt.SmoothTransformation
        # )
        # self.image_ui_element.setPixmap(scaled)

        super().resizeEvent(event)
