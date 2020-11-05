#pragma once

namespace bnb
{
    /**
     * @addtogroup utils
     * @{
     */

    template<typename Class>
    size_t class_unique_id()
    {
        static const char registrar_slot = 0;
        return reinterpret_cast<size_t>(&registrar_slot);
    }

    template<typename IdType, typename T>
    class identified_class
    {
    public:
        static IdType get_id() noexcept
        {
            return static_cast<IdType>(class_unique_id<T>());
        }
    };

    /** @} */ // endgroup utils
} // namespace bnb