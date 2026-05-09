pragma Singleton
import QtQuick

QtObject {
    property color bg: "{{ colors.surface.default.hex }}"
    property color fg: "{{ colors.on_surface.default.hex }}"
    property color surface: "{{ colors.surface_container_high.default.hex }}"
    property color accent: "{{ colors.primary.default.hex }}"
    property color dim: "{{ colors.primary_container.default.hex }}"
    property color secondary: "{{ colors.outline.default.hex }}"
    property color colError: "{{ colors.error.default.hex }}"
}
