#pragma once

namespace bnb
{
    template<typename T, size_t Size, size_t Alignment>
    class stack_pimpl
    {
    public:
        template<typename... Args>
        explicit stack_pimpl(Args&&... args) noexcept(noexcept(T(std::declval<Args>()...)))
        {
            new (ptr()) T(std::forward<Args>(args)...);
        }

        ~stack_pimpl() noexcept
        {
            static_assert(Size == sizeof(T), "Size and sizeof(T) missmatch");
            static_assert(Alignment == alignof(T), "Alignment and alignof(T) missmatch");
            ptr()->~T();
        }

        stack_pimpl(stack_pimpl&& v) noexcept(noexcept(T(std::declval<T>())))
        {
            new (ptr()) T(std::move(*v));
        }

        stack_pimpl& operator=(stack_pimpl&& rhs) noexcept(noexcept(std::declval<T&>() = std::declval<T>()))
        {
            *ptr() = std::move(*rhs);
            return *this;
        }

        T* operator->() noexcept
        {
            return ptr();
        }

        const T* operator->() const noexcept
        {
            return ptr();
        }

        T& operator*() noexcept
        {
            return *ptr();
        }

        const T& operator*() const noexcept
        {
            return *ptr();
        }

    private:
        T* ptr() noexcept
        {
            return reinterpret_cast<T*>(&m_storage);
        }

        const T* ptr() const noexcept
        {
            return reinterpret_cast<const T*>(&m_storage);
        }

        std::aligned_storage_t<Size, Alignment> m_storage;
    };
} // namespace bnb